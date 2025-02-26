view: customers {
  sql_table_name: shopify.customers ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: _id {
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }


  dimension: accepts_marketing {
    type: yesno
    sql: ${TABLE}.accepts_marketing ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: address1 {
    type: string
    sql: ${TABLE}.default_address__address1 ;;
  }

  dimension: address2 {
    type: string
    sql: ${TABLE}.default_address__address2 ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.default_address__city ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.default_address__company ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.default_address__country_name ;;
  }

  dimension: default_address__default {
    type: yesno
    sql: ${TABLE}.default_address__default ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.default_address__phone ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.default_address__zip ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    action: {
      label: "Email Promotion to Customer"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Thank you {{ customers.first_name._value }}"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Dear {{ customers.first_name._value }},

        Thanks for your loyalty!  We'd like to offer you a 10% discount
        on your next purchase!  Just use the code LOYAL when checking out!
        "
      }
    }
    required_fields: [first_name, last_name]
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension: last_order_id {
    type: number
    sql: ${TABLE}.last_order_id ;;
  }

  dimension: last_order_name {
    type: string
    sql: ${TABLE}.last_order_name ;;
  }

  dimension: note {
    type: string
    sql: ${TABLE}.note ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.orders_count ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: tax_exempt {
    type: yesno
    sql: ${TABLE}.tax_exempt ;;
  }

  dimension: total_spent_per_customer {
    type: number
    sql: ${TABLE}.total_spent::float ;;
  }


  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: verified_email {
    type: yesno
    sql: ${TABLE}.verified_email ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: total_spent {
    type: sum
    sql: ${total_spent_per_customer} ;;
    value_format_name: largeamount
    drill_fields: [detail*]
  }
  measure: avg_spent {
    type: average
    sql: ${total_spent_per_customer} ;;
    value_format_name: largeamount
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      country,
      first_name,
      last_name,
      last_order_name,
      city,
      total_spent,
      email
    ]
  }
}
