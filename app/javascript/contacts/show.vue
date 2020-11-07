<template lang='pug'>
  #contact(v-if='contact')
    .container-fluid
      .d-md-flex.flex-row
        .right.ml-md-4.order-1.w-100
          .pull-right
            b-button-toolbar
              btn-edit.mr-1(
                base-path="/administration/contacts",
                :entry-type="result.data.type",
                :entry-id="result.data.id"
              )
              show-btn-destroy(
                @destroy="destroyContact",
                :entry-ref="result.data",
              )
          h4 {{ name }}
          .description {{ description }}
        .left.order-0
          img.avatar.img-thumbnail.w-100(:src="avatarUrl")
          br
          br
          div Tel: {{ telephone }}
          div Mobile: {{ mobile }}
          div Fax: {{ fax }}
          hr.divider
          div {{ street }} {{ number }}
          div {{ zip }} {{ city }}
          div {{ country }}
</template>

<script>
import BtnEdit from '../components/btn-edit'
import ShowBtnDestroy from 'components/show-btn-destroy'
import { Utils } from 'vuex-jsonapi-client'

export default {
  props: ['contactId'],
  components: {
    BtnEdit,
    ShowBtnDestroy
  },
  mounted () {
    this.$store.dispatch('contact', this.contactId)
  },
  computed: {
    contact () {
      if (!this.result) return
      return this.$store.getters.entry({
        type: this.result.data.type,
        id: this.result.data.id
      })
    },
    name () {
      return Utils.attribute(this.contact, 'name')
    },
    description () {
      return Utils.attribute(this.contact, 'description')
    },
    telephone () {
      return Utils.attribute(this.contact, 'telephone')
    },
    mobile () {
      return Utils.attribute(this.contact, 'mobile')
    },
    fax () {
      return Utils.attribute(this.contact, 'fax')
    },
    avatarUrl () {
      return Utils.attribute(this.contact, 'avatar-url')
    },
    street () {
      return Utils.attribute(this.contact, 'address-street')
    },
    number () {
      return Utils.attribute(this.contact, 'address-number')
    },
    city () {
      return Utils.attribute(this.contact, 'address-city')
    },
    zip () {
      return Utils.attribute(this.contact, 'address-zip')
    },
    country () {
      return Utils.attribute(this.contact, 'address-country')
    }
  },
  asyncComputed: {
    result () {
      return this.$store.dispatch('contact', this.contactId)
    }
  },
  methods: {
    destroyContact () {
      this.$store.dispatch('destroyContact', this.contact)
      this.$router.push('/administration/contacts')
    }
  }
}
</script>

<style lang='sass' scoped>
.avatar
  max-width: 400px
</style>
