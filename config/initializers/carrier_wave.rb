CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_key_id'],      # 你的 key

      aws_secret_access_key: ENV['S3_key_secret'],      # 你的 secret key

      region:                'ap-northeast-1' # 你的 S3 bucket 的 Region 位置

    }
    config.fog_directory  = 'ponpon-bucket' # 你設定的 bucket name
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  else
    config.storage :file
  end
end
