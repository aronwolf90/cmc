<template lang='pug'>
  .spent-time(v-if="contact")
    .header-text
      router-link(:to="contactLink").font-weight-bold.text-dark Contact
    details-string-input(
      v-model="nameValue",
      :editMode.sync="nameEditMode",
      placeholder="Name",
      @submit="submitName",
      id="contact-name"
    )
    details-string-input(
      v-model="telephoneNumberValue",
      :editMode.sync="telephoneNumberEditMode",
      placeholder="Telephone number",
      @submit="submitTelephoneNumber",
      id="contact-telephone-number"
    )
    details-string-input(
      v-model="emailValue",
      :editMode.sync="emailEditMode",
      placeholder="E-Mail"
      @submit="submitEmail",
      id="contact-email"
    )
</template>

<script>
import DetailsStringInput from 'components/details-string-input'

const valueToAttribute = (key, value) => {
  const result = {
    attributes: {
    }
  }

  result.attributes[key] = value
  return result
}

export default {
  components: {
    DetailsStringInput
  },
  data () {
    return {
      email: {
        value: 'aron.wolf@sumcumo.com',
        editMode: false
      }
    }
  },
  computed: {
    contact () {
      return this.$store.getters['projectsShow/contact']
    },
    contactId () {
      if (!this.contact) return
      return this.contact.id
    },
    contactLink () {
      return `/administration/contacts/${this.contactId}`
    },
    nameValue: {
      get () {
        return this.$store.getters['projectsShow/contactNameValue']
      },
      set (value) {
        this.$store.commit('projectsShow/contactNameValue', value)
      }
    },
    nameEditMode: {
      get () {
        return this.$store.getters['projectsShow/contactNameEditMode']
      },
      set (value) {
        this.$store.commit('projectsShow/contactNameEditMode', value)
      }
    },
    telephoneNumberValue: {
      get () {
        return this.$store.getters['projectsShow/contactTelephoneNumberValue']
      },
      set (value) {
        this.$store.commit('projectsShow/contactTelephoneNumberValue', value)
      }
    },
    telephoneNumberEditMode: {
      get () {
        return this.$store.getters['projectsShow/contactTelephoneNumberEditMode']
      },
      set (value) {
        this.$store.commit('projectsShow/contactTelephoneNumberEditMode', value)
      }
    },
    emailValue: {
      get () {
        return this.$store.getters['projectsShow/contactEmailValue']
      },
      set (value) {
        this.$store.commit('projectsShow/contactEmailValue', value)
      }
    },
    emailEditMode: {
      get () {
        return this.$store.getters['projectsShow/contactEmailEditMode']
      },
      set (value) {
        this.$store.commit('projectsShow/contactEmailEditMode', value)
      }
    }
  },
  methods: {
    submitName () {
      this.$store.dispatch('updateContact', {
        entry: this.contact,
        payload: valueToAttribute(
          'name',
          this.nameValue
        )
      }).then(() => {
        this.nameEditMode = false 
      })
    },
    submitTelephoneNumber () {
      this.$store.dispatch('updateContact', {
        entry: this.contact,
        payload: valueToAttribute(
          'telephone',
          this.telephoneNumberValue
        )
      }).then(() => {
        this.telephoneNumberEditMode = false 
      })
    },
    submitEmail () {
      this.$store.dispatch('updateContact', {
        entry: this.contact,
        payload: valueToAttribute('email', this.emailValue)
      }).then(() => {
        this.emailEditMode = false 
      })
    }
  }
}
</script>

<style lang='sass' scoped>
  .header-text
    margin-bottom: 5px
</style>
