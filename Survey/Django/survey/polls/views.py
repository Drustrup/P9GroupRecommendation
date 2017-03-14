from django.shortcuts import render
from django.http import HttpResponse
from django.core.urlresolvers import reverse_lazy
from django.db import connections, models
from polls.models import Surveys, Groups, Userprefs, Items

#from .models import Items

# Create your views here.
def index(request):
	context = {'nav_active': 'home'}
	return render(request, 'polls/index.html', context)

def survey(request, questiongroup_id):
	groups = Surveys.objects.raw('SELECT * FROM surveys WHERE surveysid = 1')
	groupList = [groups[0].group1, groups[0].group2, groups[0].group3, groups[0].group4, groups[0].group5, groups[0].group6, groups[0].group7, groups[0].group8, groups[0].group9, groups[0].group10]
	users = Groups.objects.raw('SELECT * FROM groups WHERE groupid = %s', [groupList[0]])
	userList = [users[0].user1, users[0].user2, users[0].user3, users[0].user4, users[0].user5, users[0].user6, users[0].user7, users[0].user8]
	
	noneUsers = []
	for i in range(0, len(userList)):
		if userList[i] is None:
			noneUsers.append(i)
	noneUsers.reverse()
	for val in noneUsers:
		userList.pop(val)

	prefs = []
	for user in userList:
		items = Items.objects.raw('SELECT * FROM items LEFT JOIN (userprefs) ON (items.itemID = userprefs.item1 OR items.itemID = userprefs.item2 OR items.itemID = userprefs.item3 OR items.itemID = userprefs.item4 OR items.itemID = userprefs.item5 OR items.itemID = userprefs.item6 OR items.itemID = userprefs.item7 OR items.itemID = userprefs.item8 OR items.itemID = userprefs.item9 OR items.itemID = userprefs.item10) where userid = %s', [user])
		userPrefs = Userprefs.objects.raw('SELECT * FROM userprefs WHERE userid = %s', [user])
		itemList = []
		pref = [userPrefs[0].item1, userPrefs[0].item2, userPrefs[0].item3, userPrefs[0].item4, userPrefs[0].item5, userPrefs[0].item6, userPrefs[0].item7, userPrefs[0].item8, userPrefs[0].item9, userPrefs[0].item10]
		for p in pref:
			for i in items:
				if p == i.itemid:
					itemList.append(i.item)
		prefs.append(itemList)

	context = {'step': 0}
	context.update({'userPrefs': prefs})
	context.update({'users': userList})

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