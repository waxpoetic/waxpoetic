require 'aws/elastic_transcoder'

# Transcode a given downloadable music file to MP3. Basically all this
# job does is enqueue the transcode with ElasticTranscoder.

class Transcode < ActiveJob::Base
  # A system preset provided by AWS that enabled MP3 320kbps
  # transcoding.
  MP3_320_PRESET_ID = 1351620000001-300010

  # Use the default pipeline ID 
  def perform(downloadable)
    transcoder.create_job \
      pipeline_id: MP3_320_PRESET_ID,
      input: { key: downloadable.wav_filepath },
      outputs: [{ key: downloadable.mp3_filepath }]
  end

  private
  def transcoder
    @transcoder ||= AWS::ElasticTranscoder::Client.new
  end
end
