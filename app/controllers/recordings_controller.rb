class RecordingsController < ApplicationController
  def index
    @recordings = Recording.all
  end

  def new
    landmark = Landmark.find(params[:landmark_id])
    @recording = landmark.recordings.new
  end

  def create
    # binding.pry
    # file = File.open("app/assets/new_recording_1.mp3")
    # s3.put_object(bucket: 'oddio1903', key: 'file_1.mp3', body: file)
    file = params[:recording][:recording]
    ran = SecureRandom.hex
    file_name = "#{ran}.mp3"
    binding.pry
    s3 = Aws::S3::Client.new(profile: 'oddio1903', region: 'us-east-2')
    s3.put_object(bucket: 'oddio1903', key: file_name, body: file)
    recording = Recording.new(
      user: current_user,
      landmark_id: params[:landmark_id].to_i,
      url: "https://#{ENV['AWS_BUCKET']}.s3.#{ENV['AWS_REGION']}.amazonaws.com/#{file_name}",
      title: params[:recording][:title]
    )
    if recording.save!
      flash[:success] = "Your recording has been saved."
      redirect_to landmark_path(params[:landmark_id])
    else
      flash.now[:error] = "Unable to save recording."
      render :new
    end
  end


end
