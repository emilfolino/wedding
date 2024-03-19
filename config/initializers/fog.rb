CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider              => 'AWS',
    :aws_access_key_id     => "", #ENV['S3_KEY'],
    :aws_secret_access_key => "", #ENV['S3_SECRET']
    :host                  => "s3.eu-central-1.amazonaws.com",
    :region                => "eu-central-1"
  }

  config.fog_directory =  "" #ENV['S3_BUCKET_NAME']
  config.cache_dir     = "#{Rails.root}/tmp/uploads"   # For Heroku
  config.fog_public     = true                             # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end
