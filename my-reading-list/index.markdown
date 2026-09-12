---
layout: default
title: Reading List
---

# My Reading List

This is a living collection of software engineering, leadership books that I have read and would recommend to others. I'll add some fiction ones from time to time, although I have really limited time lately for reading and I try to focus on professional development at the moment.

{% for section in site.data.books %}
{% if section.level == 3 %}### {{ section.title }}{% else %}## {{ section.title }}{% endif %}
{% if section.intro %}
{{ section.intro }}
{% endif %}
{% for book in section.books %}
* [{{ book.title }}](https://www.amazon.com/dp/{{ book.asin }}?tag=eds02a-20){:rel="external nofollow sponsored" target="_blank"}{{ book.note }}
{%- endfor %}
{% endfor %}
