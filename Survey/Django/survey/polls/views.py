from django.shortcuts import render
from django.http import HttpResponse
from django.core.urlresolvers import reverse_lazy
from django.db import connections, models
from polls.models import Surveys, Groups, Userprefs, Items, Result
from django.views.decorators.csrf import csrf_exempt
from django.contrib.sessions.backends.db import SessionStore
import random
#from .models import Items

# Create your views here.
def index(request):
	context = {'nav_active': 'home'}
	groups = Surveys.objects.raw('SELECT * FROM surveys WHERE count = (SELECT count FROM surveys ORDER BY count ASC LIMIT 1) ORDER BY RAND() LIMIT 1')
	request.session['questiongroup_id'] = groups[0].surveysid
	request.session['step'] = 0
	return render(request, 'polls/index.html', context)

def survey(request):
	questiongroup_id = request.session['questiongroup_id']
	groups = Surveys.objects.raw('SELECT * FROM surveys WHERE surveysid = %s', [questiongroup_id])
	groupList = [groups[0].group1, groups[0].group2, groups[0].group3, groups[0].group4, groups[0].group5, groups[0].group6, groups[0].group7, groups[0].group8, groups[0].group9, groups[0].group10]
	step = request.session['step']
	if request.method == 'POST':
		result = request.POST.getlist('resarray[]', 'False')
		step = request.session['step']
		dbObject = Result(groupid = groupList[step], item1 = result[0], item2 = result[1], item3 = result[2], item4 = result[3], item5 = result[4], item6 = result[5], item7 = result[6], item8 = result[7], item9 = result[8], item10 = result[9])
		dbObject.save()

	users = Groups.objects.raw('SELECT * FROM groups WHERE groupid = %s', [groupList[step]])
	userList = [users[0].user1, users[0].user2, users[0].user3, users[0].user4, users[0].user5, users[0].user6, users[0].user7, users[0].user8]

	noneUsers = []
	for i in range(0, len(userList)):
		if userList[i] is None:
			noneUsers.append(i)
	noneUsers.reverse()
	for val in noneUsers:
		userList.pop(val)

	prefs = []
	itemList = []
	for user in userList:
		items = Items.objects.raw('SELECT * FROM items LEFT JOIN (userprefs) ON (items.itemID = userprefs.item1 OR items.itemID = userprefs.item2 OR items.itemID = userprefs.item3 OR items.itemID = userprefs.item4 OR items.itemID = userprefs.item5 OR items.itemID = userprefs.item6 OR items.itemID = userprefs.item7 OR items.itemID = userprefs.item8 OR items.itemID = userprefs.item9 OR items.itemID = userprefs.item10) where userid = %s', [user])
		userPrefs = Userprefs.objects.raw('SELECT * FROM userprefs WHERE userid = %s', [user])
		itemTemp = []
		pref = [userPrefs[0].item1, userPrefs[0].item2, userPrefs[0].item3, userPrefs[0].item4, userPrefs[0].item5, userPrefs[0].item6, userPrefs[0].item7, userPrefs[0].item8, userPrefs[0].item9, userPrefs[0].item10]
		for p in pref:
			for i in items:
				if i not in itemList:
					itemList.append(i)
				if p == i.itemid:
					itemTemp.append(i.item)
		prefs.append(itemTemp)
		
	if request.method == 'POST':	
		if step < 10:
			step = step + 1

	request.session['step'] = step
	context = {'itemlist': itemList}
	context.update({'userPrefs': prefs})
	context.update({'users': userList})
	context.update({'step': step})
	context.update({'printstep': step +1})

	return render(request, 'polls/survey.html', context)

def survey_finish(request):
	if request.session['step'] < 9:
		return render(request, 'polls/index.html')
	questiongroup_id = request.session['questiongroup_id']
	step = request.session['step']
	groups = Surveys.objects.raw('SELECT * FROM surveys WHERE surveysid = %s', [questiongroup_id])
	groupList = [groups[0].group1, groups[0].group2, groups[0].group3, groups[0].group4, groups[0].group5, groups[0].group6, groups[0].group7, groups[0].group8, groups[0].group9, groups[0].group10]

	if request.method == 'POST':
		result = request.POST.getlist('resarray[]', 'False')
		dbObject = Result(groupid = groupList[step], item1 = result[0], item2 = result[1], item3 = result[2], item4 = result[3], item5 = result[4], item6 = result[5], item7 = result[6], item8 = result[7], item9 = result[8], item10 = result[9])
		dbObject.save()

	temp = groups[0].count + 1;
	Surveys.objects.filter(surveysid = questiongroup_id).update(count = temp)	
	del request.session['step']
	del request.session['questiongroup_id']

	return render(request, 'polls/finish.html')