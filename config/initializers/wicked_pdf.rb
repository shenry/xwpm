# if Rails.env.staging? || Rails.env.production?
#   exe_path = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s
# else
#   exe_path = Rails.root.join('bin', 'wkhtmltopdf').to_s
#   # exe_path = '/usr/local/bin/wkhtmltopdf'
# end
#
# WickedPdf.config = {
#   #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
#   #:layout => "pdf.html",
#   # :exe_path => '/usr/local/bin/wkhtmltopdf'
#   :exe_path => exe_path
#
# }


if Rails.env.staging? || Rails.env.production?
  WickedPdf.config = { :exe_path => Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s }
else
  WickedPdf.config = { :exe_path => '/usr/local/bin/wkhtmltopdf' }
end