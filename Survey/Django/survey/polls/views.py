from django.shortcuts import render
from django.http import HttpResponse
from django.core.urlresolvers import reverse_lazy
from django.db import connections, models
from polls.models import Surveys, Groups

#from .models import Items

# Create your views here.
def index(request):
	context = {'nav_active': 'home'}
	return render(request, 'polls/index.html', context)

def survey(request, questiongroup_id):
	groups = Surveys.objects.raw('SELECT * FROM surveys WHERE surveysid = 1')
	groupList = [groups[0].group1, groups[0].group2, groups[0].group3, groups[0].group4, groups[0].group5, groups[0].group6, groups[0].group7, groups[0].group8, groups[0].group9, groups[0].group10]
	users = Groups.objects.raw('SELECT * FROM groups WHERE groupid = groupList[0]')

	context = {'step': 1}
	return render(request, 'polls/survey.html', context)

def survey_step(request, questiongroup_id, step):
	#Get the model fixed
	context = {}
    #context['userlist'] = MODELstuff
    #context['userprefs'] = MODELstuff
	context['questiongroup_id'] = questiongroup_id
	context['step'] = step
	return render(request, 'polls/survey.html', context)

def survey_finish(request):
	return HttpResponse("You reached the finish.")