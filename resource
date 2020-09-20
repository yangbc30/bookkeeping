#include<stdio.h>
#include<time.h>
#include<stdlib.h>
#include<string.h>
#include<windows.h>

#define maxn 105

struct record
{
	int pw;
	float nu;
	int ki;
};

record a[maxn];
const char* pw[]={"返回上一步","微信","支付宝","校园卡","银行卡","其他（如想添加请联系yangbc）"};
const char* ki[]={"返回上一步","三餐","零食","生活用品","学习资料","网购费","水费","电费","网费","其他（如想添加请联系yangbc）"};
const char* wd[]={"星期天","星期一","星期二","星期三","星期四","星期五","星期六"}; 

int get_time()
{
    time_t t;
    struct tm * lt;
    time (&t);
    lt = localtime (&t);
    return (lt->tm_year+1900)*10000+(lt->tm_mon+1)*100+ lt->tm_mday; 
}

const char* get_wday()
{
	time_t t;
    struct tm * lt;
    time (&t);
    lt = localtime (&t);
    return wd[lt->tm_wday];
}

void print(int kase)
{
	printf("日期：%d\n",get_time());
	printf("支付方式    数额    类型\n");
	for(int i=1;i<=kase;i++)
	{
		printf("%8s%8.2f%8s\n",pw[a[i].pw],a[i].nu,ki[a[i].ki]);
	}
}

void tip(int step)
{
	switch(step)
	{
		case 0:system("cls");break;
		case 1:printf("日期: %d  %s\n功能：\n【0】退出\n【1】记账\n【2】生成报表\n【3】开发者信息\n请输入数字\n",get_time(),get_wday());break;
		case 2:printf("Step1:\n选择支付方式\n【0】返回上一步\n【1】微信\n【2】支付宝\n【3】校园卡\n【4】银行卡\n【5】其他（如想添加请联系yangbc）\n请输入数字\n");break;
		case 3:printf("Step2:\n记一笔帐\n请输入金额（支出加负号）\n");break;
		case 4:printf("Step3:\n选择消费类型\n【1】三餐\n【2】零食\n【3】生活用品\n【4】学习资料\n【5】网购\n【6】水费\n【7】电费\n【8】网费\n【9】其他（如想添加请联系yangbc）\n请输入数字\n");break;
		case 5:printf("Step4:\n【0】返回选择消费类型\n【1】再记一笔\n【2】重记此笔\n请输入数字\n");break; 
		case 6:printf("Step1:\n选择报表类型\n【0】返回上一步\n【1】日结\n【2】周结\n【3】月结\n【4】自定义时间段\n请输入数字\n");break;
	}
}

int read(int start,int end)
{
//	printf("%d%d",start,end);
	
	int kase=1;
	for(int i=start;i<=end;i++)
	{
		char filename[16];
		sprintf(filename,"%d.txt",i);
		FILE *fin;
		fin=fopen(filename,"r");
		if(fin==NULL)continue;
		while(fscanf(fin,"%d",&a[kase].pw)!=EOF)
		{
			fscanf(fin,"%f%d",&a[kase].nu,&a[kase].ki);
			kase++;
		}
		fclose(fin);
	} 
	return kase-1;
} 

void save(int kase)
{
	FILE *fout; 
	char filename[16];
	sprintf(filename,"%d.txt",get_time());
	fout=fopen(filename,"a");
	for(int i=1;i<=kase;i++)
	{
		fprintf(fout,"%d %.2f %d\n",a[i].pw,a[i].nu,a[i].ki);
	}
	fclose(fout);
}

void accounting()
{
	int kase=0,payway,time=get_time(),ok;
 
	for(;;)
	{
		tip(2);
		scanf("%d",&payway);
		tip(0);
		if(payway==0){save(kase);return;}	
		for(;;)
		{
			if(kase)print(kase);
			kase++;
			a[kase].pw=payway;
			tip(3);
			scanf("%f",&a[kase].nu);
			tip(0);
			tip(4);
			scanf("%d",&a[kase].ki);
			tip(0);	
			tip(5);
			scanf("%d",&ok);
			tip(0);
			if(ok==0)break;
			if(ok==2)kase--;
		} 
	}
}

void summary_day()
{
	int time=get_time(),kase=read(time,time);
	print(kase);
	
//	printf("0");
	
	float expense=0,kind_expense[10];
	memset(kind_expense,0,sizeof(kind_expense));
	for(int i=1;i<=kase;i++)
	{
		expense+=a[i].nu;
		kind_expense[a[i].ki]+=a[i].nu;
	}
	printf("\n当日总花费: %8.2f\n",expense);
	for(int i=1;i<=8;i++)
	{
		printf("%8s:%8.2f\n",ki[i],kind_expense[i]);
	}
	system("pause");
	tip(0);
}

void summary_time_to_time(int start,int end)
{
	
	return;
}

void summary_week()
{
	
	return;
}

void summary_month()
{
	return;
}

void summary_customize()
{
	return;
}

void summary()
{
	int mode;
	for(;;)
	{
		tip(6);
		scanf("%d",&mode);
		tip(0);
		switch(mode)
		{
			case 0:return;
			case 1:summary_day();break;
			case 2:summary_week();break;
			case 3:summary_month();break;
			case 4:summary_customize();break;
		}
	}
	
}

void print_love()
{
	tip(0);
	
	
	return;
}

void information()
{
	printf("记账小程序\n开发者：yangbc\n邮箱：201870105@smail.nju.edu.cn\n请输入您的名字（获取彩蛋）\n●﹏●\n");
	char name[maxn];
	scanf("%s",name);
	if(name=="smg")print_love();
}

int main()
{
	int function;
	for(;;)
	{
		tip(1);
		scanf("%d",&function);
		tip(0);
		switch(function)
		{
			case 0:return 0;
			case 1:accounting();break;
			case 2:summary();break;
			case 3:information();break;
		}
	}
}
