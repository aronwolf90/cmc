<template lang='pug'>
  show-container(v-if="project")
    show-body
      b-button-group.pull-right
        b-button(
          variant="outline-secondary",
          :href="`/administration/projects/${id}/edit`",
          size="sm"
        )
          .fa.fa-edit
        b-button(
          variant="outline-danger",
          @click="destroy",
          size="sm"
        )
          .fa.fa-trash
      h4 {{ name }}
      markdown-viewer(:value='description')
      hr.divider
      comments(:projectId="id", module='projectsShow', v-if="project")
    right-aside.right-aside
      contact
      main-responsable
      reminder-list
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import MarkdownViewer from '../markdown_viewer'
import Comments from 'components/comments'
import ShowContainer from 'components/show-container'
import ShowBody from 'components/show-body'
import RightAside from 'components/right_aside'
import DetailsStringInput from 'components/details-string-input'
import Contact from 'components/projects/contact'
import MainResponsable from 'components/projects/main-responsable'
import ReminderList from 'components/projects/reminder-list'

export default {
  props: ['id'],
  components: {
    MarkdownViewer,
    Comments,
    ShowContainer,
    ShowBody,
    RightAside,
    Contact,
    MainResponsable,
    ReminderList
  },
  data () {
    return {
      telephoneNumber: {
        value: '+49 821 598-1111',
        editMode: false
      }
    }
  },
  created () {
    this.fetch()
  },
  computed: {
    project () {
      return this.$store.getters.project(this.id)
    },
    name () {
      return Utils.attribute(this.project, 'name')
    },
    description () {
      return Utils.attribute(this.project, 'description')
    }
  },
  methods: {
    destroy () {
      this.$store.dispatch('destroyProject', this.project).then(() => {
        this.$router.push('/administration/projects')
      })
    },
    fetch () {
      this.$store.dispatch('projectsShow/fetch', this.id)
    },
    submitTelephoneNumber () {
      this.telephoneNumber.editMode = false 
    }
  }
}
</script>
