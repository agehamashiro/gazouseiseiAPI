require 'httparty'

class StabilityAiService
    include HTTParty
    base_uri 'https://api.stability.ai'
  
    def self.generate_image(prompt)
      response = post(
        "/v2beta/stable-image/generate/SD",  # APIのエンドポイント
        headers: {
          "Authorization" => "Bearer #{ENV['STABILITY_AI_API_KEY']}",
          "Accept" => "image/*"  # 画像を期待
        },
        body: {
          "prompt" => prompt,
          "output_format" => "webp"  # 出力形式を指定
        },
        # multipart: trueを削除して、ファイル送信は必要なし
      )
  
      if response.code == 200
        return response.body  # 画像データを返す
      else
        raise "画像生成に失敗しました: #{response.body}"
      end
    end
  end
  

