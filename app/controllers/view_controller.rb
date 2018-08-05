class ViewController < ApplicationController
  def keyword
  end
  def form_for
    @book = Book.new
  end

  def field
    @book = Book.new
  end

  def col_select
    @book = Book.new(publish: '翔泳社') #ここの引数がselectedになる。
    @books = Book.select(:publish).distinct
  end

end
