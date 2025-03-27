require 'httparty'

require 'httparty'

class StabilityAiService
  include HTTParty
  base_uri 'https://api.stability.ai'

  def self.generate_image(prompt)
    response = post(
      "/v2beta/stable-image/generate/sd3",  # APIエンドポイントを変更
      headers: {
        "Authorization" => "Bearer #{ENV['STABILITY_AI_API_KEY']}",
        "Accept" => "application/json"  # JSONレスポンスを期待
      },
      body: {
        "prompt" => prompt,
        "output_format" => "png"
      },
      multipart: true  # `multipart/form-data` で送信
    )

    # APIからのレスポンスを返す
    response.parsed_response
  end
end

