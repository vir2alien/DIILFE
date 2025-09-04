#include "qmlstyles.h"
#include <QDebug>
#include <QFontMetrics>
#include <QFont>
#include <QGuiApplication>
#include <QScreen>

QmlStylesBase::QmlStylesBase(QObject *parent)
    : QObject(parent)
{

}

double QmlStylesBase::getBaseGap() const
{
    return base_gap_;
}

int QmlStylesBase::getMargins() const
{
    return base_margins_ * base_gap_;
}

int QmlStylesBase::getPopupMargins() const
{
    return popup_margins_ * base_gap_;
}

int QmlStylesBase::getTableRowHeight() const
{
    return table_row_height_ * base_gap_;
}

int QmlStylesBase::getButtonIconSize() const
{
    return button_icon_size_ * base_gap_;
}

QFont QmlStylesBase::getFont(TypeScale type_scale)
{
    return fonts_.value(type_scale);
}

void QmlStylesBase::setBaseGap(double base_gap)
{
    base_gap_ = base_gap;
    emit baseGapChanged(base_gap);
}

void QmlStylesBase::setMargins(int margins)
{
    base_margins_ = margins;
    emit marginsChanged(margins);
}

void QmlStylesBase::setPopupMargins(int margins)
{
    popup_margins_ = margins;
    emit popupMarginsChanged(margins);
}

void QmlStylesBase::setTableRowHeight(int height)
{
    table_row_height_ = height;
    emit tableRowHeightChanged(table_row_height_);
}

void QmlStylesBase::setButtonIconSize(int size)
{
    button_icon_size_ = size;
    emit buttonIconSizeChanged(size);
}


QmlStylesMobile::QmlStylesMobile(QObject *parent)
    : QmlStylesBase(parent)
{ 
    QGuiApplication *gui_application = qobject_cast<QGuiApplication*>(QGuiApplication::instance());
    if (!gui_application) {
        return;
    }
//    QScreen *screen = QGuiApplication::primaryScreen();
//    qreal dpi = screen->physicalDotsPerInch();
//  qreal ratio = dpi/BASE_DPI;
    base_gap_ = 1;//dpi/BASE_DPI;

//    qreal refHeight = 1680.;
//    qreal refWidth = 1050.;
//    QRect rect = QGuiApplication::primaryScreen()->geometry();
//    qreal height = qMax(rect.width(), rect.height());
//    qreal width = qMin(rect.width(), rect.height());
//    window_ratio_ = qMin(height/refHeight, width/refWidth);
//    qreal points = 12/qMin(height*refDpi/(dpi*refHeight), width*refDpi/(dpi*refWidth));

    fonts_.insert(TypeScale::H1, QFont(font_name_, 96, QFont::Light, false));
    fonts_.insert(TypeScale::H2, QFont(font_name_, 60, QFont::Light, false));
    fonts_.insert(TypeScale::H3, QFont(font_name_, 48, QFont::Normal, false));
    fonts_.insert(TypeScale::H4, QFont(font_name_, 34, QFont::Normal, false));
    fonts_.insert(TypeScale::H5, QFont(font_name_, 24, QFont::Normal, false));
    fonts_.insert(TypeScale::H6, QFont(font_name_, 20, QFont::Medium, false));
    fonts_.insert(TypeScale::Subtitle1, QFont(font_name_, 16, QFont::Normal, false));
    fonts_.insert(TypeScale::Subtitle2, QFont(font_name_, 14, QFont::Medium, false));
    fonts_.insert(TypeScale::Body1, QFont(font_name_, 16, QFont::Normal, false));
    fonts_.insert(TypeScale::Body2, QFont(font_name_, 14, QFont::Normal, false));
    fonts_.insert(TypeScale::BUTTON, QFont(font_name_, 14, QFont::Medium, false));
    fonts_.insert(TypeScale::Caption, QFont(font_name_, 12, QFont::Normal, false));
    fonts_.insert(TypeScale::Overline, QFont(font_name_, 10, QFont::Normal, false));

    base_margins_ = 8;
    popup_margins_ = 8;

    table_row_height_ = 24;

    button_icon_size_ = 24;
}

QmlStylesDesktop::QmlStylesDesktop(QObject *parent)
    : QmlStylesBase(parent)
{
    base_gap_ = 1.;
    fonts_.insert(TypeScale::H1, QFont(font_name_, 96, QFont::Light, false));
    fonts_.insert(TypeScale::H2, QFont(font_name_, 60, QFont::Light, false));
    fonts_.insert(TypeScale::H3, QFont(font_name_, 48, QFont::Normal, false));
    fonts_.insert(TypeScale::H4, QFont(font_name_, 34, QFont::Normal, false));
    fonts_.insert(TypeScale::H5, QFont(font_name_, 24, QFont::Normal, false));
    fonts_.insert(TypeScale::H6, QFont(font_name_, 20, QFont::Medium, false));
    fonts_.insert(TypeScale::Subtitle1, QFont(font_name_, 14, QFont::Normal, false));
    fonts_.insert(TypeScale::Subtitle2, QFont(font_name_, 13, QFont::Medium, false));
    fonts_.insert(TypeScale::Body1, QFont(font_name_, 11, QFont::Normal, false));
    fonts_.insert(TypeScale::Body2, QFont(font_name_, 10, QFont::Normal, false));
    fonts_.insert(TypeScale::BUTTON, QFont(font_name_, 11, QFont::Medium, false));
    fonts_.insert(TypeScale::Caption, QFont(font_name_, 8, QFont::Normal, false));
    fonts_.insert(TypeScale::Overline, QFont(font_name_, 7, QFont::Normal, false));

    base_margins_ = 8;
    popup_margins_ = 8;

    table_row_height_ = 24;

    button_icon_size_ = 20;
}
