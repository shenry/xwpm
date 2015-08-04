if Rails.env.staging? || Rails.env.production?
  EasyPost.api_key = "yPgo1yuzNg2w2LgJHlyyxg"
else
  EasyPost.api_key = "0ueG05wk8IS1K0t8pHU1QQ"
end