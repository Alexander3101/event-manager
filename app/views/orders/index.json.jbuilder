json.array!(@orders) do |order|
  json.extract! order, :id
  json.extract! order.event, :title, :description
  json.start order.begin_datetime
  json.end order.end_datetime
  json.url order_url(order, format: :html)
end
