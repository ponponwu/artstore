CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAI6EJGMLW2ZTYN6OA',      # 你的 key

      aws_secret_access_key: 'cazTFeorgBzR6gjb0P0K+ANw+gwalYbieKPTI8S8',      # 你的 secret key

      region:                'ap-northeast-1' # 你的 S3 bucket 的 Region 位置

    }
    config.fog_directory  = 'ponpon-bucket' # 你設定的 bucket name
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  else
    config.storage :file
  end
end
