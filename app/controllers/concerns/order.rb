module Order
  extend ActiveSupport::Concern

  def order(items)
    order = params[:order] || 'name'

    items = case order
                   when 'name' then items.sort_by{ |b| b.name }
                   when 'brewery' then items.sort_by{ |b| b.brewery.name }
                   when 'style' then items.sort_by{ |b| b.style.name }
            end
    return items
  end
end