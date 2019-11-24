<template lang='pug'>
  .admin-payment
    table.table(v-if="subscription")
      tbody.table-striped
        tr
          td Iban: **** **** **** {{ subscription.attributes['iban-last4'] }}
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
              a.pull-right.btn.btn-secondary(:href="invoice.attributes.pdf")
                i.fa.fa-file-pdf-o(aria-hidden="true")
</template>

<script>
export default {
  asyncComputed: {
    subscriptionResult () {
      return this.$store.dispatch('subscription')
    },
    invoicesResult () {
      return this.$store.dispatch('invoices')
    }
  },
  computed: {
    subscription () {
      if (!this.subscriptionResult) return
      return this.subscriptionResult.data
    },
    invoices () {
      if (!this.invoicesResult) return []
      return this.invoicesResult.data
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
