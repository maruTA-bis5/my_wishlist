# -*- coding: utf-8 -*-

Plugin.create(:my_wishlist) do
  command(:insert_wishlist,
    name: '欲しい物リストのURLを挿入',
    condition: lambda{ |opt| true },
    visible: true,
    role: :postbox
  ) do |opt|
    begin
      message = Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text
      url = "http://www.amazon.co.jp/registry/wishlist/#{UserConfig[:my_wishlist_url]}"
      if UserConfig[:my_wishlist_insert_before] then
        message = "#{url} #{message}"
      else
        message = "#{message} #{url}"
      end
      Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text = message
    end
  end
  settings "wishlist" do
    input('欲しい物リストのID', :my_wishlist_url)
      tooltip('欲しい物リストの画面で「このリストをシェアする」をクリックし、固定URLの~/wishlist/以降をコピペしてください')
    boolean('入力したテキストの前に挿入する', :my_wishlist_insert_before)
  end
end
