from django.conf.urls import url
from . import views

urlpatterns = [
	# ex: /survey/
    url(r'^$', views.index, name='index'),
    # ex: /survey/5/
    url(r'^(?P<questiongroup_id>[0-9]+)/$', views.survey, name='survey'),
    # ex: /survey/5/ with step
    url(r'^(?P<questiongroup_id>[0-9]+)/(?P<step>[0-9]+)/$', views.survey_step, name='survey_step'),
    # ex: survey/finish?auth=<auth>
    url(r'^finish/$', views.survey_finish, name='Survey finished'),
]