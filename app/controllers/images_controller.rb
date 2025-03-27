require_dependency 'stability_ai_service'
class ImagesController < ApplicationController
  def new
  end

  def create
    prompt = params[:prompt]
    Rails.logger.debug "Prompt received: #{prompt}"
  
    result = StabilityAiService.generate_image(prompt)
    Rails.logger.debug "API Response: #{result.inspect}"
  
    if result["image"]
      @image_url = result["image"]
      Rails.logger.debug "Generated Image URL: #{@image_url}"
    else
      Rails.logger.error "Image generation failed: #{result}"
    end
  
    redirect_to root_path  # ここを変更する可能性あり
  end
end