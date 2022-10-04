require 'rouge/plugins/redcarpet'

# RougeのRedcarpet対応のプラグインをincludeしたカスタムクラスのインスタンスとしてRendererを作成
class CustomRenderHTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

module MarkdownHelper
  def markdown(text)
    options = {
      no_styles:     true,  # <style>タグを生成しない
      with_toc_data: true,  # 見出しにアンカーを付ける
      hard_wrap:     true,  # 改行を<br>タグに変換
    }
    extensions = {
      no_intra_emphasis:   true,  # 単語内の強調を解析しない
      tables:              true,  # テーブルを有効化
      fenced_code_blocks:  true,  # 複数行のコードを有効化
      autolink:            true,  # http,https,ftpで始まる文字列を自動リンク
      lax_spacing:         true,  # 複数行のコードの前後に空行が不要
      space_after_headers: true,  # 見出しは#の後にスペースを空ける
    }

    # Rendererを作成
    renderer = CustomRenderHTML.new(options)
    # ソースコード部がRougeで処理され、extensionsのパラメーターが実行される
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end

  def toc(text)
    renderer = Redcarpet::Render::HTML_TOC.new(nesting_level: 3)
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(text).html_safe
  end
end