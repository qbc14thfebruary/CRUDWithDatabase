class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  class << self
    def import_file(file)

    # Chỉ cho phép import file dạng CSV
    if File.extname(file.original_filename) != ".xlsx"
      # errors.add :base, I18n.t("import.unknown_file_type")
      return
    end

      # file có thể ở dạng file hoặc là path của file đều được xử lý chính xác bởi method open
      data  = Roo::Spreadsheet.open(file.path)

      # lấy cột header (column name)
      header = data.row(1)


      # Cách 1
      # Lấy giá trị từ dòng thứ 2 trong file
      # (2..data.last_row).each do |i|
      #   # lấy ra bản ghi và biến đổi thành hash để có thể tạo record tương ứng
      #   row = [header, data.row(i)].transpose.to_h
      #   # create! row
      #   Student.create row

      # Cách 2
      data.each_with_index do |row, idx|

        # Bỏ vòng lặp đầu tiên -> loop bắt đầu idx = 0
        next if idx == 0

        # lấy ra bản ghi và biến đổi thành hash để có thể tạo record tương ứng
        article_data = Hash[[header, row].transpose]

        # puts row.name

        # article_data.url_path = file.path
        # Tạo mới
        article = Article.new(article_data)

        # article.path_url = file.path
        # puts "Saving User with email #{student.email}"

        # Lưu trữ vào database
        article.save!
      end
    end
  end
end
