# This Deface override adds a custom JavaScript module tag for the spree-zip-autocomplete module.
# It ensures that the module is included **only on the storefront side** by modifying the Spree shared head partial.
#
# Spree 5.3 追従: _head.html.erb で `javascript_importmap_tags` が `<% if %>` ブロック内で
# 2 回呼ばれる構造に変わり、`contains('javascript_importmap_tags')` ロケータでは挿入位置が
# 安定せず import タグが出力されなかった(郵便番号補完が全ページで無効化)。
# 条件分岐の外で必ず 1 度だけ現れる `yield :head` の直前に挿入する。
# @see https://github.com/be-agile/giga-repeat/issues/1210
Deface::Override.new(
  virtual_path: 'spree/shared/_head',
  name: 'spree_zip_autocomplete_add_custom_javascript_importmap_tags',
  insert_before: "erb[loud]:contains('yield :head')",
  text: <<-ERB
    <%= javascript_import_module_tag 'spree-zip-autocomplete' %>
  ERB
)
