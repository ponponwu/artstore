require 'will_paginate/view_helpers/link_renderer'
require 'will_paginate/view_helpers/action_view'

class PaginationLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
  protected
  def page_number(page)
    unless page == current_page
      tag(:li, link(page, page, :rel => rel_value(page)))
    else
      tag(:li, link(page, '#', :rel => rel_value(page)), :class => "active disabled")
    end
  end

  def gap
    tag(:li, link('...' , '#') , :class => "disabled")
  end

  def previous_or_next_page(page, text, classname)
    tag(:li, link(text , page || '#'), :class => page ? classname : classname + ' disabled')
  end

  def html_container(html)
    tag(:div , tag(:ul, html , container_attributes) , :class => 'pagination_label col-xs-12 center')
  end
end
