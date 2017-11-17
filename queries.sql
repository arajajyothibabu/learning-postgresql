/**
-- question 3
-- During the transaction period of Sep 2015 to Dec 2015, calculate the total no. of defects raised (defect type description not equal to 'No Defect') for domestic transactions (same buyer & seller country) with a country wise and defect type wise split.
*/

SELECT
  sqltest.buyer.country, sqltest.defect.defect_type, count(*)
FROM sqltest.transaction
  INNER JOIN sqltest.buyer
    ON sqltest.transaction.buyer_id = sqltest.buyer.buyer_id
  INNER JOIN sqltest.seller
    ON sqltest.transaction.seller_id = sqltest.seller.seller_id
  INNER JOIN sqltest.defect
    ON sqltest.transaction.defect_id = sqltest.defect.defect_id
WHERE sqltest.defect.defect_type_description != 'No Defect'
      AND transaction_date >= to_date('2012-09','YYYY-MM')
      AND transaction_date <= to_date('2015-12','YYYY-MM')
      AND sqltest.seller.country = sqltest.buyer.country
GROUP BY sqltest.buyer.country, sqltest.defect.defect_type;


/**
-- question 4
-- For the period Sep 2015 to Dec 2015 in US(consider buyer's country), find out the Services and their respective Carriers with most Delivery Miss defect(Delivery Miss is a type of defect). Each carrier provides multiple services e.g., Fast Shipping, Economy Shipping etc. Provide the top 3 combinations of carrier and service.
 */

SELECT TOP 3
  sqltest.service.name, sqltest.carrier.carrier_name, count(*)
FROM sqltest.transaction
  INNER JOIN sqltest.buyer
    ON sqltest.transaction.buyer_id = sqltest.buyer.buyer_id
  INNER JOIN sqltest.defect
    ON sqltest.transaction.defect_id = sqltest.defect.defect_id
  INNER JOIN sqltest.shipping
    ON sqltest.transaction.shipping_id = sqltest.shipping.shipping_id
  INNER JOIN sqltest.service
    ON sqltest.shipping.service_id = sqltest.service.service_id
  INNER JOIN sqltest.carrier
    ON sqltest.service.carrier_id = sqltest.carrier.carrier_id
WHERE sqltest.buyer.country = 'US'
  AND sqltest.defect.defect_type_description = 'Delivery Miss'
  AND transaction_date >= to_date('2012-09','YYYY-MM')
  AND transaction_date <= to_date('2015-12','YYYY-MM')
GROUP BY sqltest.service.name, sqltest.carrier.carrier_name;
