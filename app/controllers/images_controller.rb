require_dependency 'stability_ai_service'
class ImagesController < ApplicationController
  def create
    prompt = params[:prompt]
    image_data = StabilityAiService.generate_image(prompt)

    # 画像が正常に返されているかをログに出力
    Rails.logger.info "Generated image data: #{image_data}"

    # 画像データを一時的に保存する
    temp_image_path = Rails.root.join('tmp', 'generated_image.webp')
    File.open(temp_image_path, 'wb') do |file|
      file.write(image_data) # ここで画像データを保存
    end

    # 保存された画像のパスをログに出力
    Rails.logger.info "Generated image saved at: #{temp_image_path}"

    # 一時的な画像を public フォルダにコピー
    public_image_path = Rails.root.join('public', 'generated_image.webp')
    FileUtils.cp(temp_image_path, public_image_path)

    # 生成された画像のURLをビューに渡す
    @image_url = "/generated_image.webp"

    render :new
  rescue => e
    flash[:error] = "画像生成に失敗しました: #{e.message}"
    render :new
  end
end