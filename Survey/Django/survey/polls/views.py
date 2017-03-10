from django.shortcuts import render
from django.http import HttpResponse
from django.core.urlresolvers import reverse_lazy

# Create your views here.
def index(request):
	context = {'nav_active': 'home'}
	return render(request, 'polls/index.html', context)

def survey(request, questiongroup_id):
	return HttpResponse("Welcome to our survey. You have been assigned to questiongroup %s." % questiongroup_id)

def survey_finish(request):
	return HttpResponse("You reached the finish.")