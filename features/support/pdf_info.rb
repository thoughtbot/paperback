module PdfInfo
  PAGE_SIZE_6_BY_9_INCHES = %w(432 648)
  PDF_INFO_PATH = File.expand_path('../pdf_info.ps', __FILE__)
  SCREEN_FONTS = %w(ProximaNova Inconsolata)
  SHOW_EMBEDDED_FONTS_FLAG = '-dDumpFontsUsed -dShowEmbeddedFonts'
  SHOW_PAGE_SIZES_FLAG = '-dDumpMediaSizes'

  def embedded_fonts(pdf_path)
    output = pdf_info(pdf_path, SHOW_EMBEDDED_FONTS_FLAG)
    output.scan(/^[A-Z]+\+(\w+)/).flatten.uniq
  end

  def page_sizes(pdf_path)
    output = pdf_info(pdf_path, SHOW_PAGE_SIZES_FLAG)
    output.scan(/Page \d+ MediaBox: \[ (\d+) (\d+) \]/).uniq
  end

  def pdf_info(pdf_path, flags)
    in_current_dir do
      raw_output = `gs \
        -dNODISPLAY \
        -q \
        -sFile=#{pdf_path} \
        #{flags} \
        #{PDF_INFO_PATH}`
      raw_output.encode!('UTF-8', 'UTF-8', invalid: :replace)
    end
  end
end

World(PdfInfo)

