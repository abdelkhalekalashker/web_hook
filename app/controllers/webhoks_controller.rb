class WebhoksController < ApplicationController
  before_action :set_webhok, only: %i[ show update destroy approve_webhok ]
  before_action :authorize_webhok, only: %i[ show update destroy ]

  def index
    @webhoks = current_user.webhoks

    render json: @webhoks
  end

  def show
    render json: @webhok
  end

  def create
    @webhok = Webhok.new(webhok_params)

    if @webhok.save
      render json: @webhok, status: :created, location: @webhok
    else
      render json: @webhok.errors, status: :unprocessable_entity
    end
  end

  def update
    if @webhok.update(webhok_params)
      render json: @webhok
    else
      render json: @webhok.errors, status: :unprocessable_entity
    end
  end

  def approve_webhok
    if @webhok.approved!
      render json: @webhok
    else
      render json: @webhok.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @webhok.destroy
  end

  private
    def set_webhok
      @webhok = current_user.webhoks.find(params[:id])
    end

    def authorize_webhok
      unless @webhok.user_id == current_user.id
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end

    def webhok_params
      params.require(:webhok).permit(:url, :event_type).merge(user_id: current_user.id)
    end
end
