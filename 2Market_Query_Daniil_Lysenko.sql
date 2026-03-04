

1.1.The most effective social media (Way1)

SELECT m."Country",
	   ROUND (AVG(ad.twitter_ad::int),3) AS conversion_twitter,
	   ROUND (AVG(ad.facebook_ad::int),3) AS conversion_facebook,
	   ROUND (AVG(ad.instagram_ad::int),3) AS conversion_instagram
FROM public.marketing_data m
LEFT JOIN public.ad_data ad
ON m."Cust_ID" = ad. id
GROUP BY m."Country";

1.2. The most effective social media (Way2)


SELECT m."Country",
       SUM(ad.twitter_ad::int + ad.facebook_ad::int + ad.instagram_ad::int) AS total_leads,
	   SUM (ad.twitter_ad::int) AS conversion_twitter,
	   SUM (ad.facebook_ad::int)AS conversion_facebook,
	   SUM (ad.instagram_ad::int) AS conversion_instagram
FROM public.marketing_data m
LEFT JOIN public.ad_data ad
ON m."Cust_ID" = ad. id
GROUP BY m."Country";

1.3. The most effective method social media (Way3)

SELECT m."Country",
       ROUND(GREATEST(
           NULLIF(AVG(ad.twitter_ad::int), 0),
           NULLIF(AVG(ad.facebook_ad::int), 0),
           NULLIF(AVG(ad.instagram_ad::int), 0)), 3) AS highest_conversion,
       CASE 
           WHEN GREATEST(
                NULLIF(AVG(ad.twitter_ad::int), 0),
                NULLIF(AVG(ad.facebook_ad::int), 0),
                NULLIF(AVG(ad.instagram_ad::int), 0)) = AVG(ad.twitter_ad::int) THEN 'Twitter'
           WHEN GREATEST(
                NULLIF(AVG(ad.twitter_ad::int), 0),
                NULLIF(AVG(ad.facebook_ad::int), 0),
                NULLIF(AVG(ad.instagram_ad::int), 0)) = AVG(ad.facebook_ad::int) THEN 'Facebook'
           WHEN GREATEST(
                NULLIF(AVG(ad.twitter_ad::int), 0),
                NULLIF(AVG(ad.facebook_ad::int), 0),
                NULLIF(AVG(ad.instagram_ad::int), 0)) = AVG(ad.instagram_ad::int) THEN 'Instagram'
           ELSE NULL
       END AS most_effective_ad_type
FROM public.marketing_data m
JOIN public.ad_data ad
ON m."Cust_ID" = ad.id
GROUP BY m."Country"
ORDER BY highest_conversion DESC;

2.1. Marital status (Way1)


SELECT m."Marital_Status",
	   ROUND (AVG(ad.twitter_ad::int),3) AS conversion_twitter,
	   ROUND (AVG(ad.facebook_ad::int),3) AS conversion_facebook,
	   ROUND (AVG(ad.instagram_ad::int),3) AS conversion_instagram
FROM public.marketing_data m
JOIN public.ad_data ad
ON m."Cust_ID" = ad. id
GROUP BY m."Marital_Status";

2.2. Marital status (Way2)

SELECT m."Marital_Status",
       ROUND(GREATEST(
           NULLIF(AVG(ad.twitter_ad::int), 0),
           NULLIF(AVG(ad.facebook_ad::int), 0),
           NULLIF(AVG(ad.instagram_ad::int), 0)), 3) AS highest_conversion,
       CASE 
           WHEN GREATEST(
                NULLIF(AVG(ad.twitter_ad::int), 0),
                NULLIF(AVG(ad.facebook_ad::int), 0),
                NULLIF(AVG(ad.instagram_ad::int), 0)) = AVG(ad.twitter_ad::int) THEN 'Twitter'
           WHEN GREATEST(
                NULLIF(AVG(ad.twitter_ad::int), 0),
                NULLIF(AVG(ad.facebook_ad::int), 0),
                NULLIF(AVG(ad.instagram_ad::int), 0)) = AVG(ad.facebook_ad::int) THEN 'Facebook'
           WHEN GREATEST(
                NULLIF(AVG(ad.twitter_ad::int), 0),
                NULLIF(AVG(ad.facebook_ad::int), 0),
                NULLIF(AVG(ad.instagram_ad::int), 0)) = AVG(ad.instagram_ad::int) THEN 'Instagram'
           ELSE NULL
       END AS most_effective_ad_type
FROM public.marketing_data m
JOIN public.ad_data ad
ON m."Cust_ID" = ad.id
GROUP BY m."Marital_Status"
ORDER BY highest_conversion DESC;

2.3. Education (Way1)

SELECT m."Education",
	   ROUND (AVG(ad.twitter_ad::int),3) AS conversion_twitter,
	   ROUND (AVG(ad.facebook_ad::int),3) AS conversion_facebook,
	   ROUND (AVG(ad.instagram_ad::int),3) AS conversion_instagram
FROM public.marketing_data m
JOIN public.ad_data ad
ON m."Cust_ID" = ad. id
GROUP BY m."Education";

2.4. Education (Way2)

(In this case, consider the total number of lead conversions as a measure of effectiveness)SELECT m."Education",
       ROUND(GREATEST(
           NULLIF(AVG(ad.twitter_ad::int), 0),
           NULLIF(AVG(ad.facebook_ad::int), 0),
           NULLIF(AVG(ad.instagram_ad::int), 0)), 3) AS highest_conversion,
       CASE 
           WHEN GREATEST(
                NULLIF(AVG(ad.twitter_ad::int), 0),
                NULLIF(AVG(ad.facebook_ad::int), 0),
                NULLIF(AVG(ad.instagram_ad::int), 0)) = AVG(ad.twitter_ad::int) THEN 'Twitter'
           WHEN GREATEST(
                NULLIF(AVG(ad.twitter_ad::int), 0),
                NULLIF(AVG(ad.facebook_ad::int), 0),
                NULLIF(AVG(ad.instagram_ad::int), 0)) = AVG(ad.facebook_ad::int) THEN 'Facebook'
           WHEN GREATEST(
                NULLIF(AVG(ad.twitter_ad::int), 0),
                NULLIF(AVG(ad.facebook_ad::int), 0),
                NULLIF(AVG(ad.instagram_ad::int), 0)) = AVG(ad.instagram_ad::int) THEN 'Instagram'
           ELSE NULL
       END AS most_effective_ad_type
FROM public.marketing_data m
JOIN public.ad_data ad
ON m."Cust_ID" = ad.id
GROUP BY m."Education"
ORDER BY highest_conversion DESC;

3.  The most effective social media per country

SELECT m."Country", 
     CASE 
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" ELSE 0 END)
        ) = SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" ELSE 0 END)
     THEN 'Twitter'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" ELSE 0 END)
        ) = SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" ELSE 0 END)
     THEN 'Facebook'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" ELSE 0 END)
     ) = SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" ELSE 0 END)
     THEN 'Instagram'
     ELSE NULL END AS liquid,
	 CASE 
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtVege" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtVege" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtVege" ELSE 0 END)
        ) = SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtVege" ELSE 0 END)
     THEN 'Twitter'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtVege" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtVege" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtVege" ELSE 0 END)
        ) = SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtVege" ELSE 0 END)
     THEN 'Facebook'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtVege" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtVege" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtVege" ELSE 0 END)
     ) = SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtVege" ELSE 0 END)
     THEN 'Instagram'
     ELSE NULL END AS vegetables,
	 CASE 
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtNonVeg" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtNonVeg" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtNonVeg" ELSE 0 END)
        ) = SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtNonVeg" ELSE 0 END)
     THEN 'Twitter'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtNonVeg" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtNonVeg" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtNonVeg" ELSE 0 END)
        ) = SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtNonVeg" ELSE 0 END)
     THEN 'Facebook'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtNonVeg" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtNonVeg" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtNonVeg" ELSE 0 END)
     ) = SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtNonVeg" ELSE 0 END)
     THEN 'Instagram'
     ELSE NULL END AS meat,
	 CASE 
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtPes" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtPes" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtPes" ELSE 0 END)
        ) = SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtPes" ELSE 0 END)
     THEN 'Twitter'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtPes" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtPes" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtPes" ELSE 0 END)
        ) = SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtPes" ELSE 0 END)
     THEN 'Facebook'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtPes" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtPes" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtPes" ELSE 0 END)
     ) = SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtPes" ELSE 0 END)
     THEN 'Instagram'
     ELSE NULL END AS fish,
	 CASE 
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtChocolates" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtChocolates" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtChocolates" ELSE 0 END)
        ) = SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtChocolates" ELSE 0 END)
     THEN 'Twitter'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtChocolates" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtChocolates" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtChocolates" ELSE 0 END)
        ) = SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtChocolates" ELSE 0 END)
     THEN 'Facebook'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtChocolates" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtChocolates" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtChocolates" ELSE 0 END)
     ) = SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtChocolates" ELSE 0 END)
     THEN 'Instagram'
     ELSE NULL END AS chocolate,
	 	 CASE 
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtComm" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtComm" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtComm" ELSE 0 END)
        ) = SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtComm" ELSE 0 END)
     THEN 'Twitter'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtComm" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtComm" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtComm" ELSE 0 END)
        ) = SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtComm" ELSE 0 END)
     THEN 'Facebook'
     WHEN GREATEST(
     SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtComm" ELSE 0 END),
     SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtComm" ELSE 0 END),
     SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtComm" ELSE 0 END)
     ) = SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtComm" ELSE 0 END)
     THEN 'Instagram'
     ELSE NULL END AS commodity
FROM public.marketing_data m
JOIN public.ad_data ad
ON m."Cust_ID" = ad."id"
GROUP BY m."Country";

4.1. Age group 

SELECT
    CASE 
        WHEN (2024 - "Year_Birth") BETWEEN 18 AND 25 THEN '18-25'
        WHEN (2024 - "Year_Birth") BETWEEN 26 AND 35 THEN '26-35'
        WHEN (2024 - "Year_Birth") BETWEEN 36 AND 45 THEN '36-45'
        WHEN (2024 - "Year_Birth") BETWEEN 46 AND 55 THEN '46-55'
        WHEN (2024 - "Year_Birth") BETWEEN 56 AND 65 THEN '56-65'
        ELSE '65+'
    END AS age_group,
    COUNT(public.marketing_data. "Cust_ID") AS number_of_customers
FROM public.marketing_data
GROUP BY age_group
ORDER BY age_group;

4.2. Revenue per age group
SELECT
    CASE 
        WHEN (2024 - "Year_Birth") BETWEEN 18 AND 25 THEN '18-25'
        WHEN (2024 - "Year_Birth") BETWEEN 26 AND 35 THEN '26-35'
        WHEN (2024 - "Year_Birth") BETWEEN 36 AND 45 THEN '36-45'
        WHEN (2024 - "Year_Birth") BETWEEN 46 AND 55 THEN '46-55'
        WHEN (2024 - "Year_Birth") BETWEEN 56 AND 65 THEN '56-65'
        ELSE '65+'
    END AS age_group,
    ROUND(AVG("AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm"), 1) AS average_per_group
FROM public.marketing_data
GROUP BY age_group
ORDER BY average_per_group DESC;

4.3. Revenue per age group and education

SELECT 
   CASE 
        WHEN (2024 - "Year_Birth") BETWEEN 18 AND 25 THEN '18-25'
        WHEN (2024 - "Year_Birth") BETWEEN 26 AND 35 THEN '26-35'
        WHEN (2024 - "Year_Birth") BETWEEN 36 AND 45 THEN '36-45'
        WHEN (2024 - "Year_Birth") BETWEEN 46 AND 55 THEN '46-55'
        WHEN (2024 - "Year_Birth") BETWEEN 56 AND 65 THEN '56-65'
        ELSE '65+'
    END AS age_group,
    "Education",
    ROUND(AVG("AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm"), 1) AS average_per_group
FROM public.marketing_data
GROUP BY age_group, "Education"
ORDER BY average_per_group DESC;

4.4. The most effective social media by sales

SELECT m."Country", 
    SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END) AS twitter_total,
    SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END) AS facebook_total,
    SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END) AS instagram_total,
    CASE 
        WHEN GREATEST(
            SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        ) = SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        THEN 'Twitter'
        WHEN GREATEST(
            SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        ) = SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        THEN 'Facebook'
        WHEN GREATEST(
            SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        ) = SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        THEN 'Instagram'
        ELSE NULL
    END AS most_effective_ad
FROM public.marketing_data m
JOIN public.ad_data ad
ON m."Cust_ID" = ad."id"
GROUP BY m."Country";

4.5. Revenue per lead

WITH ad_summary AS (
    SELECT m."Country",
    SUM(CASE WHEN ad.twitter_ad = TRUE OR ad.facebook_ad = TRUE OR ad.instagram_ad = TRUE 
    THEN ("AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm") 
    ELSE 0 END) AS total_spend,
    SUM(ad.twitter_ad::int + ad.facebook_ad::int + ad.instagram_ad::int) AS total_leads
    FROM public.marketing_data m
    JOIN public.ad_data ad
    ON m."Cust_ID" = ad."id"
    GROUP BY m."Country"
)
SELECT "Country", total_spend, total_leads,
       CASE WHEN total_leads > 0 THEN ROUND(total_spend / total_leads, 2)
       ELSE NULL
       END AS revenue_per_lead
FROM ad_summary
ORDER BY revenue_per_lead DESC;

4.6. Revenue per lead by education and marital status

SELECT m."Education", 
    SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END) AS twitter_total,
    SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END) AS facebook_total,
    SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END) AS instagram_total,
    CASE 
        WHEN GREATEST(
            SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        ) = SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        THEN 'Twitter'
        WHEN GREATEST(
            SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        ) = SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        THEN 'Facebook'
        WHEN GREATEST(
            SUM(CASE WHEN ad.twitter_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.facebook_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END),
            SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        ) = SUM(CASE WHEN ad.instagram_ad = TRUE THEN "AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm" ELSE 0 END)
        THEN 'Instagram'
        ELSE NULL
    END AS most_effective_ad
FROM public.marketing_data m
JOIN public.ad_data ad
ON m."Cust_ID" = ad."id"
GROUP BY m."Education";

4.7. Revenue per lead by education

WITH ad_summary AS (
    SELECT m."Education",
    SUM(CASE WHEN ad.twitter_ad = TRUE OR ad.facebook_ad = TRUE OR ad.instagram_ad = TRUE 
    THEN ("AmtLiq" + "AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates" + "AmtComm") 
    ELSE 0 END) AS total_spend,
    SUM(ad.twitter_ad::int + ad.facebook_ad::int + ad.instagram_ad::int) AS total_leads
    FROM public.marketing_data m
    JOIN public.ad_data ad
    ON m."Cust_ID" = ad."id"
    GROUP BY m."Education"
)
SELECT "Education", total_spend, total_leads,
       CASE WHEN total_leads > 0 THEN ROUND(total_spend / total_leads, 2)
       ELSE NULL
       END AS revenue_per_lead
FROM ad_summary
ORDER BY revenue_per_lead DESC;


