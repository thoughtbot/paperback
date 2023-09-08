require "pdf-reader"

module PdfInfo
  PAGE_SIZE_6_BY_9_INCHES = [0, 0, 432, 648]
  SCREEN_FONTS = %w[OpenSans Inconsolata]

  def embedded_fonts(pdf_path)
    pdf_info(pdf_path)
      .pages
      .map { |page| page.fonts.values }
      .flatten
      .map { |spec| spec[:BaseFont].to_s.scan(/^[A-Z]+\+(\w+)/).first }
      .flatten
      .uniq
  end

  def page_sizes(pdf_path)
    pdf_info(pdf_path)
      .pages
      .map { |page| page_size(page) }
      .uniq
  end

  def page_size(page)
    objects = page.objects.values

    media_object = objects.detect do |object|
      object.respond_to?(:to_hash) && object.to_hash[:MediaBox]
    end

    media_object[:MediaBox]
  end

  def pdf_info(pdf_path)
    in_current_directory do
      PDF::Reader.new pdf_path
    end
  end
end

World PdfInfo
