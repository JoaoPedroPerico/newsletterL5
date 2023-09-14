class TemplatesController < ApplicationController
    def new
      @template = Template.new
    end
 
    def create
        @template = Template.new(template_params)
  
      if @template.save
        redirect_to emails_path, notice: "Template saved"
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
      def template_params
        params.require(:template).permit(:name, :body)
      end
  end