require "sinatra"

module Paperback
  class Server < Sinatra::Base
    get "/" do
      html = Paperback::Package.book.target(:html)
      send_file Paperback.target_root.join(html)
    end
  end
end
