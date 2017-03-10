from django.conf.urls import url
from . import views

urlpatterns = [
	# ex: /survey/
    url(r'^$', views.index, name='index'),
    # ex: /survey/5/
    url(r'^(?P<questiongroup_id>[1-5])/$', views.survey, name='survey'),
    # ex: survey/finish?auth=<auth>
    url(r'^finish/$', views.survey_finish, name='Survey finished'),
]