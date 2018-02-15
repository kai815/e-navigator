class InterviewsController < ApplicationController
  before_action :set_interview, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:index, :update]

  def index
    @other_user_inteviews = @user.interviews.order(start_time: :asc)
    @interviews = current_user.interviews.order(start_time: :asc)
    @approved_interview = @user.interviews.approved[0]
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
    if current_user.id == @user.id
      if @interview.update(interview_params)
        redirect_to user_interviews_path, notice: "面接日程を更新しました。"
      else
        render :edit
      end
    else
      @change_intervew = @user.interviews
      @change_intervew.update(status: 2)
      if @interview.update(status: 1)
        redirect_to user_interviews_path, notice: "面接日程を確定しました。"
      else
        render :edit
      end
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

  def set_user
    @user = User.find(params[:user_id])
  end
end
