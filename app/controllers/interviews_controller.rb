class InterviewsController < ApplicationController
  before_action :set_interview, only: [:edit, :update, :destroy]

  def index
    @interviews = current_user.interviews.order(start_time: :asc)
  end

  def new
    @interview = Interview.new
  end

  def create
    @interview = Interview.new(interview_params)
    if @interview.save
      redirect_to user_interviews_path, notice: "面接日程を追加しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @interview.update(interview_params)
      redirect_to user_interviews_path, notice: "面接日程を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @interview.destroy
      redirect_to user_interviews_path, notice: "面接日程を削除しました。"
    else
      render :index
    end
  end

  private

  def interview_params
    params.require(:interview).permit(:start_time).merge(user_id: params[:user_id])
  end

  def set_interview
    @interview = Interview.find(params[:id])
  end
end
