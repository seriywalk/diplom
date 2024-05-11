// Create bucket with key
resource "yandex_storage_bucket" "bucket_net" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = "seriywalk-bucket"
    acl    = "public-read"
}

