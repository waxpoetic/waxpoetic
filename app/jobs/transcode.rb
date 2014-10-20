require 'aws/elastic_transcoder'

# Transcode a given Track to MP3. Simply adds a new job onto the
# ElasticTranscoder queue.

class Transcode < ActiveJob::Base
  # A system preset provided by AWS that enabled MP3 320kbps
  # transcoding.
  MP3_320_PRESET_ID = 1351620000001-300010

  def perform(filepath)
    transcoder.create_job \
      pipeline_id: MP3_320_PRESET_ID,
      input: { key: filepath },
      outputs: [{ key: filepath.gsub(/\.wav\Z/, '.mp3') }]
  end

  private
  def transcoder
    @transcoder ||= AWS::ElasticTranscoder::Client.new
  end
end
