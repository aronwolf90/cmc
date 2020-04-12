<template lang='pug'>
  .spent-time
    mt-2
    .font-weight-bold Contact
    details-string-input(
      v-model="telephoneNumberValue",
      :editMode.sync="telephoneNumberEditMode",
      @submit="submitTelephoneNumber"
    )
    details-string-input(
      v-model="emailValue",
      :editMode.sync="emailEditMode",
      @submit="submitEmail"
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
    telephoneNumberValue: {
      get () {
        return this.$store.getters['projectsShow/telephoneNumberValue']
      },
      set (value) {
        this.$store.commit('projectsShow/telephoneNumberValue', value)
      }
    },
    telephoneNumberEditMode: {
      get () {
        return this.$store.getters['projectsShow/telephoneNumberEditMode']
      },
      set (value) {
        this.$store.commit('projectsShow/telephoneNumberEditMode', value)
      }
    },
    emailValue: {
      get () {
        return this.$store.getters['projectsShow/emailValue']
      },
      set (value) {
        this.$store.commit('projectsShow/emailValue', value)
      }
    },
    emailEditMode: {
      get () {
        return this.$store.getters['projectsShow/emailEditMode']
      },
      set (value) {
        this.$store.commit('projectsShow/emailEditMode', value)
      }
    }
  },
  methods: {
    submitTelephoneNumber () {
      this.$store.dispatch('updateContact', {
        entry: this.$store.getters['projectsShow/contact'],
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
        entry: this.$store.getters['projectsShow/contact'],
        payload: valueToAttribute('email', this.emailValue)
      }).then(() => {
        this.emailEditMode = false 
      })
    }
  }
}
</script>

<style lang='sass'>
</style>
