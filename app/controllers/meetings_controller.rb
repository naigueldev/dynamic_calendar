class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    new_start_date = @meeting.start_date.to_date
    new_end_time = @meeting.end_time.to_date
    # p "new_start_date = #{new_start_date}"
    # p "new_end_time = #{new_end_time}"

    flag = false
    @meetings = Meeting.all
    @meetings.each do |meeting|
      # p "meetings : #{meeting.id}"

      startdate = (meeting.start_date).to_date
      enddate = (meeting.end_time).to_date
      # p "startdate = #{startdate}"
      # p "enddate = #{enddate}"
      range_date = (startdate..enddate).to_a

      unless range_date.include?("#{new_start_date}") || range_date.include?("#{new_end_time}")
        p "YES - #{new_start_date}"
        flag = true
      end


      # p "range_date = #{range_date}"
      # range_date.each do |day|
      #   day_date = day.to_date
      #   p "day : #{day.to_date}"
      #
      #   range_date2.each do |day2|
      #     day_date2 = day2.to_date
      #     p "day2 : #{day2.to_date}"
      #     if day_date2 == day_date
      #       p "Período de data já cadastrada"
      #       flag = true
      #     end
      #   end
      #
      # end


    end

    if flag
      respond_to do |format|
        format.js
      end
      # redirect_to request.referrer
    else
      respond_to do |format|
        if @meeting.save
          format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
          format.json { render :show, status: :created, location: @meeting }
        else
          format.html { render :new }
          format.json { render json: @meeting.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:name, :start_date, :end_time)
    end
end
