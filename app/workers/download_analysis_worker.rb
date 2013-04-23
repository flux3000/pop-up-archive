# encoding: utf-8

require 'utils'

class DownloadAnalysisWorker
  include Sidekiq::Worker

  def perform(audio_file_id, analysis_url)
    connection = Fog::Storage.new(audio_file.file.fog_credentials)
    uri = URI.parse(transcript_url)
    analysis = Utils.download_private_file(connection, uri)

    audio_file = AudioFile.find(audio_file_id)
    audio_file.item.process_analysis(analysis)    
  end

end
