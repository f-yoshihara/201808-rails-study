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

  def nest
    @msg = '今日も良い天気です。'
    render layout: 'child'
  end

  def partial_basic
    @book = Book.find(1)
  end

  def partial_col
    @book = Book.all
  end

  def partial_param
    @book = Book.find(1)
  end

end
