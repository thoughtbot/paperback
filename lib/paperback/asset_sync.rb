require "asset_sync"
require "dotenv"
require "paperback/git"

Dotenv.load

AssetSync.configure do |config|
  config.aws_access_key_id = ENV["AWS_ACCESS_KEY_ID"]
  config.aws_secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
  config.custom_headers = { ".*" => { public: false } }
  config.existing_remote_files = "delete"
  config.fog_directory = ENV["AWS_BUCKET"]
  config.fog_provider = "AWS"
  config.log_silently = false
  config.prefix = Paperback::Git.repository_name
  config.public_path = "build"
end
