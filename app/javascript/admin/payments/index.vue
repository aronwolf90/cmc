<template lang='pug'>
  .table-responsive
    table.table
      thead
        th Created at
        th Amount paid
        th Amount due
        th Amount remaining
        th
          b-button.pull-right(
            variant="success",
            @click="click"
          ) Add payment informations
      tbody
        tr(v-for="invoice in invoices")
          td {{ invoice.attributes['created-at'] }}
          td {{ invoice.attributes['amount-paid'] }}
          td {{ invoice.attributes['amount-due'] }}
          td {{ invoice.attributes['amount-remaining'] }}
          td
</template>

<script>
export default {
  asyncComputed: {
    result () {
      return this.$store.dispatch('invoices')
    }
  },
  computed: {
    invoices () {
      if (!this.result) return []
      return this.result.data
    }
  },
  methods: {
    click () {
      this.$store.dispatch('createStripeCheckoutSession').then(result => {
        const stripe = Stripe('pk_test_jnjnLmEpUo9tbTIEjKKGPr62007x2iQKkM');
        stripe.redirectToCheckout({
          sessionId: result.data.data.id
        }).then(function (result) {
          alert(result)
        })
      })
    }
  }
}
</script>

<style lang='sass'>
</style>
