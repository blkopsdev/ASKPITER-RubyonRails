module Paperclip

  interpolates :placeholder do |attachment, style|
    asset_name = "#{attachment.send :interpolate, ':class'}_#{attachment.name}_#{style}"
    ActionController::Base.helpers.asset_path("#{asset_name}.png")
  end

  class Attachment

    def cleanup_filename filename
      return filename_cleaner.call(filename) if @options[:filename_cleaner]
      mime = MIME::Types[@file.content_type.to_s.strip].first
      ext = mime.try(:extensions).try(:first) || File.extname(filename)
      ext = ".#{ext}" if ext.present? && ext.first != '.'
      "#{SecureRandom.hex}#{ext}"
    end

    default_options.merge!({
      default_url: ':placeholder',
    })

    unless %w(development test).include? Rails.env
      default_options.merge!({
        storage: :s3,
        path: ':class/:attachment/:id_partition/:style/:filename',
        url: ':s3_domain_url',
        s3_credentials:
        {
          bucket: ENV['S3_BUCKET_NAME'],
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        },
      })
    end

  end
end
