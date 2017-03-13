from django.shortcuts import render
from django.http import HttpResponse
from django.core.urlresolvers import reverse_lazy

#from .models import Items

# Create your views here.
def index(request):
	context = {'nav_active': 'home'}
	return render(request, 'polls/index.html', context)

def survey(request, questiongroup_id):
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