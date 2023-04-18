class ArticlesController < ApplicationController

  # before_action :show

  def index
    # Hiển thị hết toàn bộ danh sách
    # @articles = Article.all

    # # #TÌm kiếm: filter
    # @q = Article.ransack(params[:q])
    # @articles = @q.result(distinct: true)

    # Phân chia trang
    @articles = Article.paginate(:page => params[:page], :per_page =>5)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
      # redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    puts "edit"
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    debugger

    if @article.update(article_params)
      redirect_to :action => 'show', :id => @article
      # redirect_to root_path
    else
      render action: :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy!

    redirect_to root_path
  end

  # Import file
  def import
    Article.import_file(params[:file])
    redirect_to root_path, notice: "Data imported"
  end


  # Upload file
  def uploadFile
    uploadedFile = params[:uploadFile][:file]
    File.open(Rails.root.join('public', 'files', uploadedFile.original_filename), 'wb') do |f|
      f.write(uploadedFile.read)
    end
    redirect_to root_path
  end

  # Download File
  def downloadFile
    fileName = params[:downloadFile][:fileName]


    file_path = Rails.root.join('public', 'files', fileName)
    debugger
    send_file(file_path)
    # send_file("#{Rails.root}/public/files/DTS.pdf",
    #             filename: "DTS.pdf",
    #             :type => 'application/pdf/docx/html/htm/doc',
    #             :disposition => 'attachment')


    redirect_to '/articles/test'
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
