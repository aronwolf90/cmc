import PagesProjectsRecordsIndex from 'pages/projects/_id/records/index'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('pages/projects/_id/records/index', () => {
  const relationship = sandbox.stub()
  const factory = ({ projectRecordDays = [] }) => {
    return createWrapper(PagesProjectsRecordsIndex, {
      mocks: {
        $store: {
          getters: {
            'projectsRecordsIndex/projectRecordDays': projectRecordDays,
            relationship
          }
        }
      }
    })
  }

  it('render project record days with records', () => {
    const projectRecordDay = {
      id: '1',
      type: 'project-record-days',
      attributes: {
        day: '10-10-2020',
        'spent-time': 3600
      }
    }
    const record = {
      id: '1',
      type: 'records',
      attributes: {
        description: 'Test description',
        'start-time': '2020-10-10T10:00:00.000+01:00',
        'end-time': '2020-10-10T11:00:00.000+01:00'
      },
      meta: {
        permissions: {
          update: true
        }
      }
    }
    relationship.returns([record])
    const wrapper = factory({ projectRecordDays: [projectRecordDay] })

    expect(wrapper.html()).to.include('10-10-2020')
    expect(wrapper.html()).to.include('01:00:00')
    expect(wrapper.html()).to.include('Test description')
    expect(wrapper.html()).to.include('10:00')
    expect(wrapper.html()).to.include('11:00')
  })
})
