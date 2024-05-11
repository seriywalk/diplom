# terraform service_account
resource "yandex_iam_service_account" "tf-sa" {
  name = "tf-sa"
}

# role
resource "yandex_resourcemanager_folder_iam_member" "tf-sa-editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.tf-sa.id}"
  depends_on = [yandex_iam_service_account.tf-sa]
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "tf-key" {
  service_account_id = yandex_iam_service_account.tf-sa.id
  depends_on         = [yandex_resourcemanager_folder_iam_member.tf-sa-editor]
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "serwalk" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.tf-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.tf-key.secret_key

  anonymous_access_flags {
    read = false
    list = false
  }
  force_destroy = true
  depends_on    = [yandex_iam_service_account_static_access_key.tf-key]
}

resource "local_file" "backend-conf" {
  content    = <<EOT
access_key = "${yandex_iam_service_account_static_access_key.tf-key.access_key}"
secret_key = "${yandex_iam_service_account_static_access_key.tf-key.secret_key}"
EOT
  filename   = "backend.key"
  depends_on = [yandex_storage_bucket.serwalk]
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "yc iam key create --folder-name default --service-account-name tf-sa --output ./keys/key.json"
  }
  depends_on = [yandex_resourcemanager_folder_iam_member.tf-sa-editor]
}
