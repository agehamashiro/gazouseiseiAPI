require_dependency 'stability_ai_service'
class ImagesController < ApplicationController
  def new
  end

  def create
    prompt = params[:prompt]
    result = StabilityAiService.generate_image(prompt)
    Rails.logger.debug "API Response: #{result}"
  
    if result["image"]
      # 画像データがbase64で返される場合、それをビューに渡す
      @image_data = result["image"]
    else
      flash[:error] = "画像生成に失敗しました: #{result['errors']}"
    end
  
    # ホームページへリダイレクト
    redirect_to root_path
  end
end